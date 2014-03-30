class DashboardController < ApplicationController
before_filter :authenticate_user!

  def overview
  end

  def transactions
  end

  def budgets
  end

  def trends
  end

  def ways_to_save
  end
end
