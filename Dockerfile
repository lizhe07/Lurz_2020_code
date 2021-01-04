FROM zheli18/pytorch:1.7.1-cp38-cuda110-1804 AS base
RUN pip install -U pip setuptools jupyterlab sklearn visdom seaborn datajoint

FROM base as git-repos
RUN mkdir /root/.ssh/
COPY id_rsa /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone git@github.com:lizhe07/jarvis
RUN git clone git@github.com:sinzlab/nnfabrik
RUN git clone git@github.com:lizhe07/Lurz_2020_code

FROM base as final
COPY --from=git-repos /jarvis /jarvis
RUN pip install -e jarvis
COPY --from=git-repos /nnfabrik /nnfabrik
RUN pip install -e nnfabrik
COPY --from=git-repos /Lurz_2020_code /Lurz_2020_code
WORKDIR Lurz_2020_code
