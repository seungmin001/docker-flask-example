# syntax=docker/dockerfile:1
# docker builder가 parsing할 때 사용할 syntax 지정

# ARG로 원하는 이미지 이름을 --build-arg옵션을 사용하여 부여할 수 있다.
ARG BASE_IMG=python:3.9-alpine
# base Image 지정 (multi-stage build 사용 시 as 사용)
FROM ${BASE_IMG} as base

# 이미지 정보에 Maintainer 넣기
LABEL maintainer="minnie9808@gmail.com"

# 패키지 업데이트 및 bash 설치
RUN apk update && apk upgrade && \
    apk add --no-cache bash

# 작업 디렉토리 지정. 이후 command들의 상대경로는 workdir에서부터의 경로
WORKDIR /app

# requirements 설치를 위한 파일 복사
COPY requirements.txt ./

# requirements.txt에 적힌 패키지 버전대로 패키지 설치
RUN pip install -r requirements.txt

# COPY src dst 파일 복사 (현재 폴더 아래의 모든것을 container 파일 시스템 내 /app/에 복사)
COPY . /app/

# 실행
CMD [ "python", "./app.py"]