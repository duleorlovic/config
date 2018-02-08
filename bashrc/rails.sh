#/bin/bash
#
# Rails related helpers

last_migration(){
  vim db/migrate/$(ls db/migrate/ | sort | tail -1)
}

last_neo4j_migration(){
  vim db/neo4j/migrate/$(ls db/neo4j/migrate/ | sort | tail -1)
}

show_memory(){
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this function open image that shows current memory used in rails
    http://blog.trk.in.rs/2015/09/10/ruby-memory-leak-track/#plotting-on-png
    example usage:
    show_memory log/development.log # development is default log
    show_memory heroku
	HERE_DOC
    return
  fi
  log_file=${1-log/development.log}
  if [ ! -f tmp/memory_profile.png ]; then
    echo_red Downloading sample tmp/memory_profile.png
    wget http://www.fnordware.com/superpng/pngtest16rgba.png -O tmp/memory_profile.png
  fi
  if [ "$log_file" = "heroku" ];then
    log_command="heroku logs -t | grep -o app.web.1.*"
  else
    log_command="tail $log_file -f"
  fi
  cat >> log/memory_profile.log << HERE_DOC
MEMORY[19668]: time: 2016-11-08 18:07:59 +0100 rss: 116564, live_objects: 453269
HERE_DOC
  # tail -n 10000 $log_file | grep -o MEMORY.* --line-buffered | tee log/memory_profile.log
  eval $log_command | grep -o MEMORY.* --line-buffered | tee log/memory_profile.log \
  & gnuplot lib/memory_profile.gp & feh --reload 1.3 tmp/memory_profile.png \
  ; fg; echo "press CTRL+C one more time" ; fg
}

function load_dump() {
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this function to load dump file into rails db
    http://blog.trk.in.rs/2016/04/12/rails-tips/#dump-database
    example usage:
    load_dump tmp/b001.dump # default is development
    load_dump tmp/b001.dump production
	HERE_DOC
    return
  fi
  if [ "$1" == "" ]; then
    echo You need to provide dump file name. Get help with load_dump -h
    return
  fi
  dump_file=${1}
  if [ ! -f "$dump_file" ]; then
    echo I cant find $dump_file
    return
  fi
  rails_env=${2:-development}
  db_name=$(rails runner "puts ActiveRecord::Base.configurations['$rails_env']['database']")
  echo_red Drop $db_name for $rails_env
  RAILS_ENV=$rails_env rake db:drop
  RAILS_ENV=$rails_env rake db:create db:migrate
  sudo su postgres -c "pg_restore -d $db_name --clean --no-acl --no-owner -h localhost $dump_file"
  echo_red "Finish loading"
}
