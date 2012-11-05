class ContactMessage < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  validates_presence_of :email, :name, :message
  validates_length_of :phone_number, :within => (10..11), :allow_blank => true
  validates_format_of :email, :with => EmailAddressValidation::EMAIL_ADDRESS_EXACT_PATTERN
  
  before_validation :sanitize_phone_number
  after_create :deliver_email_notification
  
  private
  
  def sanitize_phone_number
    write_attribute(:phone_number, phone_number.strip.gsub(/\D/, "")) if phone_number.present?
  end
  
  def deliver_email_notification
    Notifier.new_contact_message(self).deliver
  end
  
end
