#!/usr/bin/ruby1.8
path = `echo $GEDIT_CURRENT_DOCUMENT_PATH`
path.gsub!("\n", "")
path = path.split("/")
doc = path.delete(path[-1])

dirs = []
if path.include?('app') || path.include?('spec')
	path.size.times do
		dir = path.delete(path[-1])
		break if dir == 'app' || dir == 'spec'
		dirs << dir
	end
end

if doc.match(/erb_spec.rb/)
  doc_to_open = doc[0..-9]
  dirs << "app" if dirs.count > 0
elsif doc.match(/spec.rb/)
  doc_to_open = doc[0..-9] + ".rb"
  dirs << "app" if dirs.count > 0
elsif doc.match(/\.erb/)
  doc_to_open = doc + "_spec.rb"
  dirs << "spec" if dirs.count > 0
elsif doc.match(/\.rb/)
  dirs << "spec" if dirs.count > 0
  doc_to_open = doc[0..-4] + "_spec.rb"
else
  raise "The file is not one .rb, .erb or Spec of a Rails project."
end

dirs = dirs.reverse.join("/")
root = path.join("/")

`gedit "#{root}/#{dirs}/#{doc_to_open}" `

