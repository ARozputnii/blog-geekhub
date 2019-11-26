module ApplicationHelper
  def updated(sample)
    true if sample.updated_at.to_s != sample.created_at.to_s
  end

  # count actions
  def pop_up
    true if cookies[:"actions"] % 5 == 0
  end
end
