module PostsHelper
  def full_name(post)
    "#{Author.find(post.author_id).first_name.capitalize} #{Author.find(post.author_id).last_name.capitalize}"
  end
end
