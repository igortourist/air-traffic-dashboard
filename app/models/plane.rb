class Plane < ActiveRecord::Base
  PENDING_STATE = 'pending'
  TAKEOFF_STATE = 'takeoff'
  FLIGHT_STATE  = 'flight'
  LANDING_STATE = 'landing'
  TAKEOFF_LANDING_DURATION = 2.seconds

  has_many :activities, dependent: :destroy

  validates :status,
    inclusion: {in: [PENDING_STATE, TAKEOFF_STATE, FLIGHT_STATE, LANDING_STATE]}

  after_save :store_activity

  def flight?
    status == FLIGHT_STATE
  end

  def pending?
    status == PENDING_STATE
  end

  def flight_control
    Resque.enqueue(Runway, id, send("status_after_#{status}"))
  end

  def status_after_takeoff
    FLIGHT_STATE
  end

  def status_after_landing
    PENDING_STATE
  end

  protected
  
  def store_activity
    if status_changed?
      Activity.create(status: status, plane_id: id)
    end
  end
end
