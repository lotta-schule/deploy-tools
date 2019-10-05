FROM aoepeople/digital-ocean-helper

WORKDIR /user/local/bin

COPY setup.sh /user/local/bin/setup.sh
RUN chmod u+x /user/local/bin/setup.sh

ENTRYPOINT [ "/user/local/bin/setup.sh" ]