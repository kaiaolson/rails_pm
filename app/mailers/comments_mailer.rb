class CommentsMailer < ApplicationMailer

  def notify_discussion_owner(comment)
    @user = comment.user
    @discussion = comment.discussion
    mail(to: @user.email, subject: "#{@user.full_name} has commented on your discussion!")
  end
end
