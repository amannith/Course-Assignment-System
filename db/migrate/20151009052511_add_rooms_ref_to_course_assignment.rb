class AddRoomsRefToCourseAssignment < ActiveRecord::Migration
  def change
    add_reference :course_assignments, :rooms, index: true, foreign_key: true
  end
end
