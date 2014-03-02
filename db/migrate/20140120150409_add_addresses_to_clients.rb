class AddAddressesToClients < ActiveRecord::Migration
  def change
    add_reference :clients, :address, index: true
  end
end
