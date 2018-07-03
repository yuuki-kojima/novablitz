module ApplicationHelper
  def page_title
    title = "Let's Play NovaBlitz"
    title = @page_title + " | " + title if @page_title
    title
  end

  def md_to_html(text)
    options = {
      hard_wrap:       true,
      space_after_headers: true,
    }

    extensions = {
      autolink:           true,
      no_intra_emphasis:  true,
      fenced_code_blocks: true,
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def set_time(time)
    return time.strftime("%Y年%m月%d日")
  end

  def default_meta_tags
    {
      site: "Let's Play NovaBlitz",
      title: '',
      reverse: true,
      charset: 'utf-8',
      description: 'トレーディングカードゲーム「NovaBlitz」の日本人向け情報サイトです。',
      keywords: 'NovaBlitz, Dapps, TCG',
      canonical: 'https://lp-novablitz.com/',
      separator: '|',
      og: {
        site_name: "Let's Play NovaBlitz",
        title: '',
        description: 'トレーディングカードゲーム「NovaBlitz」の日本人向け情報サイトです。',
        type: 'website',
        url: 'https://lp-novablitz.com/',
        image: image_url('site_image.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        title: "Let's Play NovaBlitz",
        site: '@_torike',
        image: image_url('site_image.png')
      }
    }
  end

end
