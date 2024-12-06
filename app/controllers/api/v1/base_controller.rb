class Api::V1::BaseController < ApplicationController
  before_action :render_unauthorized, unless: :user_signed_in?
  skip_forgery_protection

  protected

  def render_unauthorized
    render_message  ['You are not authorized to perform this action'], :unauthorized
  end

  def render_message(messages, status = :ok)
    render partial: 'api/v1/share/message',
           locals: { messages: messages },
           status: status
  end
end
