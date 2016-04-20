class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create	
		@contact = Contact.create(contact_params)
		redirect_to new_note_path
	end

	private

	def contact_params
    params.require(:contact).permit(:name, :number)
  end
end
