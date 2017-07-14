class SpecialTrinomial < ApplicationRecord
  belongs_to :user
  after_initialize :create_roots

  def create_root
    self.root1 ||= rand(1..13)
    self.save
  end

  

end
