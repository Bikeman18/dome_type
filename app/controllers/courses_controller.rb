class CoursesController < ApplicationController
  before_action :require_user, only: [:apply]

  def index
    course=Course.where(status: 1)
    if cookies[:area]
      course = course.where(district_id: 9)
    end
    @courses = course.select(:id, :name).page(params[:page]).per(params[:per])
  end

  def show
    @course = Course.find(params[:id])
    if current_user.present?
      @has_apply = CourseUserShip.where(user_id: current_user.id, course_id: params[:id]).exists?
      @user_info = UserProfile.left_joins(:school, :district).where(user_id: current_user.id).select(:grade, :username, :district_id, :school_id, 'districts.name as district_name', 'schools.name as school_name').first ||= current_user.build_user_profile
    end
  end

  def apply
    username = params[:username]
    district_id = params[:district]
    school_id = params[:school]
    grade = params[:grade]
    cd = params[:cd]
    if username.present? && district_id.present? && school_id.present? && grade.present? && cd.present?
      has_apply= CourseUserShip.where(user_id: current_user.id, course_id: cd).exists?
      if has_apply
        result=[false, '您已经报名该比赛']
      else
        if current_user.user_profile.update_attributes!(username: username, grade: grade, district_id: district_id, school_id: school_id)
          c_u = CourseUserShip.create!(user_id: current_user.id, course_id: cd, school_id: school_id, grade: grade)
          if c_u.save
            result = [true, '报名成功']
          else
            result = [false, '报名失败']
          end
        else
          result = [false, '信息填写不规范']
        end
      end
    else
      result = [false, '信息不完整']
    end
    render json: result
  end
end
