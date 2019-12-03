module ApplicationHelper
  # check updated or not
  def updated(sample)
    true if sample.updated_at.to_s != sample.created_at.to_s
  end

  # count actions
  def pop_up
    true if cookies[:"actions"] % 5 == 0
  end
end


# gem ancestry (for nested comments)
def ancestry_nested_comments(comments)
  comments.map do |comment, sub_comments|
    render(comment) + content_tag(:div, ancestry_nested_comments(sub_comments), class: 'ancestry_nested_comments')
  end.join.html_safe
end


# check owner or admin or not, time limit 1 hour
def check_edit_rights(current_user, sample)
  true if (current_user.id == sample.author_id && Time.now - sample.created_at < 3600 && current_user.baned == false)
end


#dislike
def count_value(sample)
  sample.where(value: nil).count
end
#like
def count_vote(sample)
  sample.where(vote: nil).count
end