class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top terms privacy coordination faq]

  def top; end
  def terms; end
  def privacy; end
  def coordination; end
  def faq; end
end
