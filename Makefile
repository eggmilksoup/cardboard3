all: bin/count           \
     bin/countemoji      \
     bin/emojicat        \
     bin/formatrcp       \
     bin/identify-voters \
     bin/logdms          \
     bin/logmentions     \
     bin/mention         \
     bin/mkthread        \
     bin/msg             \
     bin/nickname        \
     bin/pullrcp         \
     bin/rcp             \
     bin/status          \
     bin/username

bin/count: src/count.go
	cd bin && go build ../src/count.go

bin/countemoji: src/countemoji.go
	cd bin && go build ../src/countemoji.go

bin/emojicat: src/emojicat.go
	cd bin && go build ../src/emojicat.go

bin/formatrcp: src/formatrcp.go
	cd bin && go build ../src/formatrcp.go

bin/identify-voters: src/identify-voters.go
	cd bin && go build ../src/identify-voters.go

bin/logdms: src/logdms.go
	cd bin && go build ../src/logdms.go

bin/logmentions: src/logmentions.go
	cd bin && go build ../src/logmentions.go

bin/mention: src/mention.go
	cd bin && go build ../src/mention.go

bin/mkthread: src/mkthread.go
	cd bin && go build ../src/mkthread.go

bin/msg: src/msg.go
	cd bin && go build ../src/msg.go

bin/nickname: src/nickname.go
	cd bin && go build ../src/nickname.go

bin/pullrcp: src/pullrcp.go
	cd bin && go build ../src/pullrcp.go

bin/rcp: src/rcp.go
	cd bin && go build ../src/rcp.go

bin/status: src/status.go
	cd bin && go build ../src/status.go

bin/username: src/username.go
	cd bin && go build ../src/username.go

clean:
	rm bin/*
