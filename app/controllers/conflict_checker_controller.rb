class ConflictCheckerController < ApplicationController
include ConflictCheckerHelper
  def index

    # @day_combo_row = DayCombination.find_by day_combination: params[:day_combo]
    @day_combo_row = DayCombination.find_by day_combination: "TR" # Hard coded for testing
    # @time_slot_row = TimeSlot.find_by time_slot: params[:time_slot]
    @time_slot_row = TimeSlot.find_by time_slot: "9:35 am to 10:50 am" # Hard coded for testing
    # @building = params[:building]
    @building = "HRBB" # "Please select ..." or "HRBB" Hard coded for testing
 
    # ToDo: Get the semester_id from the session
    @semester_id = 1

    @relevant_preferences = Array.new # Course Name, Course Title, Faculty name, preference, preference #
    i = j = 0
    # j = 0
    @conflicts = Array.new # Faculty Name, Course Name, Course Title, Building name, Note, Preference #, Assigned?

    case @building
    when "Please select ..."
       # Case 1: When building is not chosen (=> only Day-Combo and time-slot were chosen):
       # @faculty_preferences = FacultyPreference.find_by semester_id: @semester_id
       @faculty_preferences = FacultyPreference.all

       @faculty_preferences.each do |faculty_preference|

         @pref1_id = faculty_preference.preference1_id
         @pref_1 = Preference.find_by id: @pref1_id
         @pref2_id = faculty_preference.preference2_id
         @pref_2 = Preference.find_by id: @pref2_id
         @pref3_id = faculty_preference.preference3_id
         @pref_3 = Preference.find_by id: @pref3_id

	 @course_id = faculty_preference.faculty_course_id
	 # Now using course_id, get course name & title from Course using helper method
	 @courseRow = courseDetails(@course_id)
	 @course_name = @courseRow.course_name #.course_name [1]
	 @course_title = @courseRow.CourseTitle #.CourseTitle [4]
	 # Then using course_id, get faculty_id from FacultyCourse using helper method
	 @faculty_id = findFacultyforCourse(@course_id)
	 # Now using faculty_id, get Faculty_name from Faculty using helper method
	 @faculty_name = findFacultyName(@faculty_id)

         # Check Pref 1
	 if ( (@pref_1) && (@pref_1.day_combination_id == @day_combo_row.id) && ((findTimeSlotDataFromId((@pref_1.time_slot_id)).time_slot == @time_slot_row.time_slot)))
	    @relevant_preferences.insert(i, [@course_name, @course_title, @faculty_name, @pref_1, 1])
	    i += 1
	 end
         # Check Pref 2
	 if ( (@pref_2) && (@pref_2.day_combination_id == @day_combo_row.id) && ((findTimeSlotDataFromId((@pref_2.time_slot_id)).time_slot == @time_slot_row.time_slot)))
	    @relevant_preferences.insert(i, Array[@course_name, @course_title, @faculty_name, @pref_2, 2])
	    i += 1
	 end
         # Check Pref 3
	 if ( (@pref_3) && (@pref_3.day_combination_id == @day_combo_row.id) && ((findTimeSlotDataFromId((@pref_3.time_slot_id)).time_slot == @time_slot_row.time_slot)))
	    @relevant_preferences.insert(i, Array[@course_name, @course_title, @faculty_name, @pref_3, 3])
	    i += 1
	 end  
       
       end

       @relevant_preferences.each do |relevant_preference|
        # Faculty Name
	@fac_name = relevant_preference[2]
	# Course Details
	@cour_name = relevant_preference[0] # .course_name
	@cour_title = relevant_preference[1] # .CourseTitle
	# Building
	@building_name = (findBuildingDataFromId((relevant_preference[3]).building_id)).building_name
	# Note
	@note = relevant_preference[3].note
	# Preference number
	@pref_no = relevant_preference[4]
	# Already Assigned
	@already_asgn = isAssigned((relevant_preference[3])[4], (relevant_preference[3])[5], (relevant_preference[3])[6]) # building_id, day_combination_id, time_slot_id

        @conflicts.insert(j, Array[@fac_name, @cour_name, @cour_title, @building_name, @note, @pref_no, @already_asgn])
	j += 1
       end

    else
       # Case 2: When building is also chosen
       @building_row = Building.find_by building_name: @building
       # @faculty_preferences = FacultyPreference.find_by semester_id: @semester_id
       @faculty_preferences = FacultyPreference.all

       @faculty_preferences.each do |faculty_preference|

         @pref1_id = faculty_preference.preference1_id
         @pref_1 = Preference.find_by id: @pref1_id
         @pref2_id = faculty_preference.preference2_id
         @pref_2 = Preference.find_by id: @pref2_id
         @pref3_id = faculty_preference.preference3_id
         @pref_3 = Preference.find_by id: @pref3_id

	 @course_id = faculty_preference.faculty_course_id
	 # Now using course_id, get course name & title from Course using helper method
	 @courseRow = courseDetails(@course_id)
	 @course_name = @courseRow.course_name #.course_name [1]
	 @course_title = @courseRow.CourseTitle #.CourseTitle [4]
	 # Then using course_id, get faculty_id from FacultyCourse using helper method
	 @faculty_id = findFacultyforCourse(@course_id)
	 # Now using faculty_id, get faculty_name from Faculty using helper method
	 @faculty_name = findFacultyName(@faculty_id)

         # Check Pref 1
         # @pref_1 = Preference.find_by preference_id: @pref1_id
	 if ( (@pref_1) && (@pref_1.day_combination_id == @day_combo_row.id) && ((findTimeSlotDataFromId((@pref_1.time_slot_id)).time_slot == @time_slot_row.time_slot)) && (@pref_1.building_id == @building_row.id) )
	    @relevant_preferences.insert(i, [@course_name, @course_title, @faculty_name, @pref_1, 1])
	    i += 1
	 end
         # Check Pref 2
	 if ( (@pref_2) && (@pref_2.day_combination_id == @day_combo_row.id) && ((findTimeSlotDataFromId((@pref_2.time_slot_id)).time_slot == @time_slot_row.time_slot)) && (@pref_2.building_id == @building_row.id) )
	    @relevant_preferences.insert(i, Array[@course_name, @course_title, @faculty_name, @pref_2, 2])
	    i += 1
	 end
         # Check Pref 3
	 if ( (@pref_3) && (@pref_3.day_combination_id == @day_combo_row.id) && ((findTimeSlotDataFromId((@pref_3.time_slot_id)).time_slot == @time_slot_row.time_slot)) && (@pref_3.building_id == @building_row.id) )
	    @relevant_preferences.insert(i, Array[@course_name, @course_title, @faculty_name, @pref_3, 3])
	    i += 1
	 end  
       
       end

       @relevant_preferences.each do |relevant_preference|
        # Faculty Name
	@fac_name = relevant_preference[2]
	# Course Details
	@cour_name = relevant_preference[0] # .course_name
	@cour_title = relevant_preference[1] # .CourseTitle
	# Building (Group By)
	@building_name = (findBuildingDataFromId((relevant_preference[3]).building_id)).building_name
	# Note
	@note = relevant_preference[3].note
	# Preference number
	@pref_no = relevant_preference[4]
	# Already Assigned
	# @already_asgn = true
	@already_asgn = isAssigned((relevant_preference[3])[4], (relevant_preference[3])[5], (relevant_preference[3])[6]) # building_id, day_combination_id, time_slot_id

        @conflicts.insert(j, Array[@fac_name, @cour_name, @cour_title, @building_name, @note, @pref_no, @already_asgn])
	j += 1
       end 

    end

    # @conflicts = FacultyPreference.find_by_sql("SELECT *, COUNT(*) FROM faculty_preferences GROUP BY preference1_id HAVING COUNT(*) > 1")
  end
end

=begin
Models and their columns:
1. Building: building_id, building_name (s)
2. Room: room_id, room_name (s), building_id (i), Capacity (i)
3. DayCombination: day_combination_id, day_combination (s)
4. TimeSlot: time_slot_id, time_slot (s)
5. Preference: preference_id, note, building_id, day_combination_id, time_slot_id, semester_id (i)
6. FacultyPreference: faculty_preference_id, faculty_course_id (i), preference1_id (i), preference2_id (i), preference3_id (i), semester_id (i)
7. Course: course_id (i), course_name (s), CourseTitle (s)
8. FacultyCourse: faculty_id (i), course1_id (i), course2_id (i), course3_id (i), semester_id (i)
9. Faculty: faculty_id (i), faculty_name (s)
10. CourseAssignment: faculty_id (i), course_id (i), room_id (i), day_combination_id (i), time_slot_id (i), semester_id (i)
=end
