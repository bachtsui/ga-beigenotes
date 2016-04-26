class ContactsController < ApplicationController

	def create	
		@user = current_user
		@contact = Contact.create(contact_params)
		@user.contacts << @contact
		redirect_to "/users/#{current_user.slug}/notes"
	end

	private

	def contact_params
    params.require(:contact).permit(:name, :number, :location)
  end
end
