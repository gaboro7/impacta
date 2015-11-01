# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  nombre             :string(255)      not null
#  email              :string(255)      not null
#  encrypted_password :string(255)      not null
#  salt               :string(255)
#  admin              :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
