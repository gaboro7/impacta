# == Schema Information
#
# Table name: mail_internos
#
#  id           :integer          not null, primary key
#  mail         :string(255)
#  conmail_id   :integer          not null
#  conmail_type :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class MailInterno < ActiveRecord::Base

  email_reg = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  belongs_to :conmail, :polymorphic => true



  def self.mail_valido(mail)
    mail =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  end

  private


  validates :mail, :presence => {:message => "Debe agregar una direccion de correo."}, :format => { :with => email_reg,:message => "El e-mail no es valido." }

end
