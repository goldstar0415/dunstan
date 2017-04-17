class Keypad < ApplicationRecord
  belongs_to :admin, :class_name => "User", foreign_key: 'admin_id'

  has_many :user_keypads, dependent: :destroy
  has_many :users, through: :user_keypads

  has_one :keypad_state, dependent: :destroy
  has_many :keypad_histories, dependent: :destroy

  validates :admin_id, presence: true
  validates :number, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  # after_create :send_sms

  def add_user user
    UserKeypad.create!(user_id:user.id,keypad_id:self.id) if user.present?
  end

  def json_data
    {id:id, number:number, code:code, status:status}
  end

  # def send_sms
  #   KeypadWorker::perform_async(self.admin_id.to_s, self.keypad_id)
  # end
end
