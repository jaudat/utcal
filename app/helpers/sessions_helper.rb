module SessionsHelper
	@current_type = nil

	def sign_in(user)
		session[:remember_token] = user.id

		if @current_type ||= Student.find_by_user_id(session[:remember_token]).nil?
			@current_type = "Professor"
		elsif @current_type ||= Professor.find_by_user_id(session[:remember_token]).nil?
			@current_type = "Student"
		end
		session[:type] = @current_type
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		if session[:remember_token].nil?
			@current_user = nil
		else
			@current_user ||= User.find(session[:remember_token])
		end
	end

	def signed_in?
		!current_user.nil?
	end

	def signed_student?
		Student.find_by_user_id(session[:remember_token]).nil?
	end

	def signed_type
		# returns either professor or student depending on what it is
		@current_type = session[:type]
		if @current_type == nil
			if @current_type ||= Student.find_by_user_id(session[:remember_token]).nil?
				@current_type = "Professor"
			elsif @current_type ||= Professor.find_by_user_id(session[:remember_token]).nil?
				@current_type = "Student"
			end
		end
		@current_type
	end

	def sign_out
		self.current_user = nil
		session[:remember_token] = nil
		@current_type = nil
		session[:type] = nil
	end

	def current_user?(user)
		user == @current_user
	end
end
