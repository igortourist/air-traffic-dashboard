class Runway
  include PlaneMessenger::Status
  
  @queue = :takeoff_landing

  def self.perform(plane_id, new_status)
    plane = Plane.find_by(id: plane_id)
    
    if plane
      sleep(Plane::TAKEOFF_LANDING_DURATION)
      
      plane.status = new_status
      plane.save
      PlaneMessenger::Status.change(plane)
    end
  end
end
