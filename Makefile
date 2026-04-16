.PHONY: build serve clean

build:
	bundle exec jekyll build

serve:
	bundle exec jekyll serve --livereload

clean:
	bundle exec jekyll clean
