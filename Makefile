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
     bin/msgdel          \
     bin/nickname        \
     bin/pullrcp         \
     bin/rcp             \
     bin/status          \
     bin/username

bin/count: src/count.go
	go build -o bin/count src/count.go

bin/countemoji: src/countemoji.go
	go build -o bin/countemoji src/countemoji.go

bin/emojicat: src/emojicat.go
	go build -o bin/emojicat src/emojicat.go

bin/formatrcp: src/formatrcp.go
	go build -o bin/formatrcp src/formatrcp.go

bin/identify-voters: src/identify-voters.go
	go build -o bin/identify-voters src/identify-voters.go

bin/logdms: src/logdms.go
	go build -o bin/logdms src/logdms.go

bin/logmentions: src/logmentions.go
	go build -o bin/logmentions src/logmentions.go

bin/mention: src/mention.go
	go build -o bin/mention src/mention.go

bin/mkthread: src/mkthread.go
	go build -o bin/mkthread src/mkthread.go

bin/msg: src/msg.go
	go build -o bin/msg src/msg.go

bin/msgdel: src/msgdel.go
	go build -o bin/msgdel src/msgdel.go

bin/nickname: src/nickname.go
	go build -o bin/nickname src/nickname.go

bin/pullrcp: src/pullrcp.go
	go build -o bin/pullrcp src/pullrcp.go

bin/rcp: src/rcp.go
	go build -o bin/rcp src/rcp.go

bin/status: src/status.go
	go build -o bin/status src/status.go

bin/username: src/username.go
	go build -o bin/username src/username.go

clean:
	rm bin/*
