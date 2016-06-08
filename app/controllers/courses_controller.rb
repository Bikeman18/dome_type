class CoursesController < ApplicationController
  before_action :require_mobile, only: [:apply]

  def index
    @courses = Course.where(status: 1).select(:id, :name).page(params[:page]).per(params[:per])
  end

  def show
    @course = Course.find(params[:id])
    @has_apply = CourseUserShip.where(user_id: current_user.id, course_id: params[:id]).exists?
    @user_info = current_user.user_profile ||= current_user.build_user_profile
  end

  def apply
    username = params[:username]
    district_id = params[:district]
    school_id = params[:school]
    grade = params[:grade]
    cd = params[:cd]
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
    flash[:notice] = result[1]
    redirect_to "/courses/#{params[:cd]}"
  end
end

