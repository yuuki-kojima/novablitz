module ApplicationHelper
  def page_title
    title = "Let's Play NovaBlitz" #ここにデフォルトの名前を入れてください。
    title = @page_title + " | " + title if @page_title
    title
  end
end
