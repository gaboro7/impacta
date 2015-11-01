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

class Empresa < Cliente
  has_many :sucursals, :dependent => :destroy
  has_many :contactos, :as => :contactable, :dependent => :destroy


  private

  validates :nombrefiscal, :presence => { :message => "Debe ingresar Nombre Fiscal." }, :uniqueness => {:message => "Ya existe una Empresa con el mismo Nombre fiscal.", :case_sensitive => false}
  validates :nif, :presence => {:message => "Debe ingresar R.U.T."}, :uniqueness => {:message => "Ya existe una Empresa con el mismo R.U.T.", :case_sensitive => false}
  
  before_save :agregarnombre


  
  def agregarnombre
    self.nombre = self.nombrefiscal
    if (self.nombrereal == "")
        self.nombrereal = self.nombrefiscal
    end
  end
  
end

