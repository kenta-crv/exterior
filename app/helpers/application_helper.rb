module ApplicationHelper
  def default_meta_tags
    {
      site: "",
      title:"<%= yield(:title) | 『エクステリアガーデン』' %>",
      description: "外構・エクステリア工事の一括比較見積り『エクステリアガーデン』。",
      charset: "UTF-8",
      reverse: true,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('favicon.ico'),  rel: 'apple-touch-icon' },
      ]
    }
  end

end
