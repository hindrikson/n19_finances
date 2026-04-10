class MonthlyChecksController < ApplicationController
  def index
    @monthly_checks = MonthlyCheck.order(month: :desc)
  end

  def show
    date = Date.parse("#{params[:id]}-01")
    @monthly_check = MonthlyCheck.find_by!(month: date.beginning_of_month..date.end_of_month)
  end
end
