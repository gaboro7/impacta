class UserMailer < ActionMailer::Base
  default from: "panificadoraargentina@gmail.com"

  def enviar(cliente,cabezal,mensaje,path,filename)
    attachments[filename] = File.read(path,  :mode => 'rb')
    mail(:from => 'panificadoraargentina@gmail.com', :to => cliente, :subject => cabezal,:body => mensaje)
  end


end
