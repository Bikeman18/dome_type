class TeamUserShip < ApplicationRecord
  belongs_to :team, counter_cache: :players
  belongs_to :user
  belongs_to :event
  belongs_to :school
  belongs_to :district
  validates :team_id, presence: true
  validates :user_id, presence: true, uniqueness: {scope: :team_id, message: '一个用户只能以一个队伍报名'}
  validates :event_id, presence: true
  # validates :school_id, presence: true, numericality: {only_integer: true}
  # validates :grade, presence: true, numericality: {only_integer: true}
  # validates :district_id, presence: true, numericality: {only_integer: true}
end
