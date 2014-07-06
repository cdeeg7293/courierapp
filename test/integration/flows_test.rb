require 'test_helper'

class FlowsTest < ActionDispatch::IntegrationTest  
  fixtures :all
  
  test "user must login before site browsing" do
    controller_names = ["client", "contact_type", "courier", "order"]
    #if the user in not logged in - redirect to login path
    controller_names.each do |name|
      get "/#{name.pluralize}"
      assert_redirected_to new_user_session_path
      assert_equal I18n.translate('devise.failure.unauthenticated'), flash[:alert]
    end
    
    get root_path
    assert_response :redirect
    get new_user_session_path
    assert_response :success
    post_via_redirect new_user_session_path, 'user[email]' => 'a@b.c', 'user[password]' => 'pwd'  
    assert_equal I18n.translate('devise.sessions.signed_in'), flash[:notice]
    assert_equal root_path, path
    
    #after login all controllers should be accessible
    controller_names.each do |name|
      get "/#{name.pluralize}"
      assert_equal "/#{name.pluralize}", path
      assert_response :success
    end
  end
  
  test "creating an order" do
    log_in
    sender = create_client(:sender_1)
    receiver = create_client(:receiver_1)
    select_client(sender, :sender, new_order_path)
    select_client(receiver, :receiver, new_order_path)
    
    get new_order_path
    assert_response :success
    post_via_redirect orders_path, order: { sender_id: session[:sender], receiver_id: session[:receiver], sum: 18.99 }
    assert_equal order_path(assigns(:order)), path
  end
  
  def log_in
    get new_user_session_path
    assert_response :success
    post_via_redirect new_user_session_path, 'user[email]' => 'a@b.c', 'user[password]' => 'pwd'  
    assert_equal path, root_path
  end
  
  def create_client(client_symbol)
    @client = clients(client_symbol)
    @contact = contacts(client_symbol.to_s + '_contact')
    post_via_redirect clients_path, client: { first_name: @client.first_name, last_name: @client.last_name, patronymic: @client.patronymic, is_person: @client.is_person, address_attributes: { city: @client.address.city, street: @client.address.street, building: @client.address.building, apartment: @client.address.apartment }, contacts_attributes: [ contact_type_id: @contact.contact_type.id, value: @contact.value ] }
    #assert_nil assigns(:client).errors
    #Rails::logger.debug flash.inspect
    assert_equal client_path(assigns(:client)), path
    assigns(:client)
  end
    
  def select_client(client, client_role, origin_path)
    get origin_path
    assert_response :success
    get_via_redirect select_srr_orders_path(:srflag => client_role), {}, {'HTTP_REFERER' => origin_path} 
    assert_equal client_role, session[:srflag]
    #assert_response :redirect
    assert_equal clients_path, path
    #TODO: asserting that a link "select" exists
    #asserting that an extra column for select is present (normally there are 3)
    assert_select 'table' do
	assert_select 'th', 4
    end
    #assert_select "table tr td:first-child a", {:html => /clients\/\d+\/select/ }
    post_via_redirect select_client_path(client.id)
    assert_equal client.id, session[client_role]
    assert_equal origin_path, path
  end
  # test "the truth" do
  #   assert true
  # end
end
