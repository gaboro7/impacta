# == Schema Information
#
# Table name: tipoclientes
#
#  id         :integer          not null, primary key
#  nombre     :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tipocliente < ActiveRecord::Base
  has_many :cliente
  has_many :mail_internos, :as => :conmail, :dependent => :destroy

  private

  validates :nombre, :presence => {:message => "Debe ingresar un nombre al Grupo."}, :uniqueness => {:message => "Ya existe un Grupo con el mismo Nombre.", :case_sensitive => false}
end
