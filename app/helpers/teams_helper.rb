module TeamsHelper

	def generate_teams
		unassigned_students = []
		Student.all.each do |student|
			unassigned_students.push(student.name)
		end

  		num_teams = params[:num].to_i
		team_size = unassigned_students.count / num_teams

		teams = []
	
		until teams.count == num_teams
		teammates = unassigned_students.sample(team_size)
		teams.push(teammates)

			teammates.each do |student|
			unassigned_students.delete(student)
			end
		end

		unassigned_students.each_with_index do |students, index|
			teams[index].push(students)
		end
	
		return teams
	end

	def save_teams

	    Team.destroy_all # discard any earlier teams

	    if @teams != nil

		    @teams.each do |team|
			    # set rand num leader index
		        # and ref 0 index to get string form

		        @leader = rand(0...team.count)

		        team[@leader] += '*'

			    Team.create(members: team.join(', '))
		    end
		end
  	end
end
