# == Schema Information
#
# Table name: contactos
#
#  id               :integer          not null, primary key
#  nombre           :string(255)      not null
#  sector           :string(255)
#  interno          :integer
#  comentarios      :text
#  contactable_id   :integer          not null
#  contactable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Contacto < ActiveRecord::Base
  has_many :telefonos, :as => :contelefono, :dependent => :destroy
  has_many :mail_internos, :as => :conmail, :dependent => :destroy
  belongs_to :contactable, :polymorphic => true

  private

  validates :nombre, :presence => {:message => "Debe ingresar un Nombre para el Contacto."}
end

