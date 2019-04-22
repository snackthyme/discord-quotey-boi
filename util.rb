def extract_quote_parts(str)
    command, quote, *name = str.split(/\s(?=(?:[^"]|"[^"]*")*$)/)
    name = name.join(' ').sub(/^-/,'').strip
    quote = quote [1...-1]
    {command: command, name: name, quote: quote}
end

def generate_id(len)
    possible_chars = [*?0..?9].concat([*?a..?z])
    len.times.map { possible_chars.sample }.join
end

def replace_users(str, mentions)
    str.scan(/<@\!?([0-9]+)>/).flat_map{|x|x}.each do |id|
        mention = mentions.find {|m| m.id.to_s == id}
        str.gsub!(/<@\!?#{Regexp.quote(mention.id.to_s)}>/, mention.distinct)
    end
    str
end
