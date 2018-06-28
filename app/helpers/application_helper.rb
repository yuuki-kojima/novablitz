module ApplicationHelper
  def page_title
    title = "Let's Play NovaBlitz"
    title = @page_title + " | " + title if @page_title
    title
  end

  def qiita_markdown(markdown)
    processor = Qiita::Markdown::Processor.new(hostname: "example.com")
    processor.call(markdown)[:output].to_s.html_safe
  end

  def set_time(time)
    return time.strftime("%Y年%m月%d日")
  end
end
