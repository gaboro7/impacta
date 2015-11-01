# == Schema Information
#
# Table name: clientes
#
#  id             :integer          not null, primary key
#  type           :string(255)      not null
#  credito        :boolean          default(FALSE)
#  precargo       :float
#  urecargo       :string(255)
#  cantrecargo    :integer
#  pdescuento     :integer          default(0)
#  habilitado     :boolean          default(TRUE)
#  listaprecio_id :integer
#  tipocliente_id :integer
#  domicilio      :string(255)      not null
#  departamento   :string(255)
#  barrio         :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  nombre         :string(255)      not null
#  nic            :string(255)
#  nombrereal     :string(255)
#  nombrefiscal   :string(255)
#  nif            :string(255)
#  dirweb         :string(255)
#

class Persona < Cliente
  has_many :domicilios, :dependent => :destroy

  private

  validates :nombre, :presence => { :message => "Debe ingresar Nombre." }
  #validate  :nic_val


  def nic_val
    errors.add(:nic,"Ya existe una Persona registrada con la misma Cedula" ) if !self.nic.empty? and !Persona.where(:nic => self.nic).empty?

  end

end

