class PlanesController < ApplicationController
  def index
    @planes = Plane.all
  end

  def flight
    plane = Plane.find_by(id: params[:id])
    plane.status = params[:status]

    respond_to do |format|
      format.html
      format.json {
        if plane.save
          plane.flight_control
          render json: {plane: plane}
        else
          render json: {errors: plane.errors.full_messages}, status: :unprocessable_entity
        end
      }
    end
  end

  def activities
    @plane = Plane.find_by(id: params[:id])
    @activities = @plane.activities.order(created_at: :desc)
  end
end
