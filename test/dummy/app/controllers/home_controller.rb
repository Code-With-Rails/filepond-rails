# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :setup_model

  def index; end

  def update
    @some_model.update(model_params)
    redirect_to root_path
  end

  def destroy
    @some_model.picture.purge
    redirect_to root_path
  end

  private

  def setup_model
    @some_model ||= SomeModel.first_or_create
  end

  def model_params
    params.require(:some_model).permit(:picture)
  rescue ActionController::ParameterMissing
    {}
  end
end
