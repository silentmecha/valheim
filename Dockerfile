FROM silentmecha/steamcmd:latest

LABEL maintainer="silent@silentmecha.co.za"

ENV STEAMAPP_ID 896660
ENV STEAMAPP Valheim
ENV STEAMAPPDIR "${HOME}/${STEAMAPP}-dedicated"
ENV STEAM_SAVEDIR "${STEAMAPPDIR}/Saves"

USER root

COPY ./src/entry.sh ${HOME}/entry.sh

RUN set -x \
	&& mkdir -p "${STEAMAPPDIR}" \
    && mkdir -p "${HOME}/mcrcon" \
	&& mkdir -p "${HOME}/.config/unity3d/IronGate/Valheim" \
    && wget -c https://github.com/Tiiffi/mcrcon/releases/download/v0.7.1/mcrcon-0.7.1-linux-x86-64.tar.gz -O - | tar -xz -C "${HOME}/mcrcon" --strip-components=1\
	&& chmod +x "${HOME}/entry.sh" \
	&& ln -s "${HOME}/.config/unity3d/IronGate/Valheim" ${STEAM_SAVEDIR} \
	&& chown -R "${USER}:${USER}" "${HOME}/entry.sh" "${STEAMAPPDIR}" "${HOME}" \
	&& chmod -R 744 "${STEAM_SAVEDIR}" "${HOME}/.config/"

ENV SERVER_NAME="Valheim Docker" \
	PORT=2456 \
	WORLD="Dedicated" \
	SERVER_PASSWORD="secret"

# Switch to user
USER ${USER}

RUN bash steamcmd \
	+login anonymous \
	+force_install_dir "${STEAMAPPDIR}" \
	+app_update "${STEAMAPP_ID}" validate \
	+quit

VOLUME ${STEAM_SAVEDIR}

WORKDIR ${HOME}

EXPOSE 	2456/udp \
        2457/udp \
        2458/udp \
        2456/tcp \
        2457/tcp \
        2458/tcp


CMD ["bash", "entry.sh"]
