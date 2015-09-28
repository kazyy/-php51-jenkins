FROM centos:5
RUN yum install -y epel-release
RUN rpm -U --force http://rpms.famillecollet.com/enterprise/remi-release-5.rpm

# PHP関連インストール
RUN yum install -y php \
  php-pecl-xdebug \
  php-xml \
  php-devel \
  php-pear-XML-Serializer \
  php-channel-phpunit \
  php-pear-PHP-CodeSniffer

RUN pear config-set preferred_state beta

RUN pear channel-discover pear.phing.info
RUN pear channel-discover pear.netpirates.net
RUN pear channel-discover pear.symfony.com

RUN pear install --force --onlyreqdeps phing/phing-2.9.1

ADD function.php /usr/share/php/
ADD phing.ini /etc/php.d/

# jenkinsインストール
RUN yum install -y java-1.7.0-openjdk-devel
RUN curl -o /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum install -y jenkins
RUN chkconfig jenkins on

# capistranoインストール
RUN yum install -y zlib-devel openssl-devel gcc make
RUN curl -O http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz && \
  tar xf ruby-2.1.5.tar.gz && \
  cd ruby-2.1.5 && \
  ./configure && \
  make install
RUN gem install capistrano -v 2.15.4 --no-ri --no-rdoc
#RUN gem uninstall net-ssh
#RUN gem install net-ssh --no-ri --no-rdoc

ENTRYPOINT service jenkins start && /bin/bash
