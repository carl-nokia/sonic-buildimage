# docker image for sFlow agent

DOCKER_SFLOW_STEM = docker-sflow
DOCKER_SFLOW = $(DOCKER_SFLOW_STEM).gz
DOCKER_SFLOW_DBG = $(DOCKER_SFLOW_STEM)-$(DBG_IMAGE_MARK).gz

$(DOCKER_SFLOW)_PATH = $(DOCKERS_PATH)/$(DOCKER_SFLOW_STEM)

$(DOCKER_SFLOW)_DEPENDS += $(SWSS) $(REDIS_TOOLS) $(HSFLOWD) $(SFLOWTOOL) $(PSAMPLE)
$(DOCKER_SFLOW)_DBG_DEPENDS = $($(DOCKER_CONFIG_ENGINE_STRETCH)_DBG_DEPENDS)
$(DOCKER_TEAMD)_DBG_DEPENDS += $(SWSS_DBG) $(LIBSWSSCOMMON_DBG)
$(DOCKER_SFLOW)_DBG_IMAGE_PACKAGES = $($(DOCKER_CONFIG_ENGINE_STRETCH)_DBG_IMAGE_PACKAGES)

$(DOCKER_SFLOW)_LOAD_DOCKERS += $(DOCKER_CONFIG_ENGINE_STRETCH)

SONIC_DOCKER_IMAGES += $(DOCKER_SFLOW)
ifeq ($(ENABLE_SFLOW), y)
SONIC_INSTALL_DOCKER_IMAGES += $(DOCKER_SFLOW)
SONIC_STRETCH_DOCKERS += $(DOCKER_SFLOW)
endif

SONIC_DOCKER_DBG_IMAGES += $(DOCKER_SFLOW_DBG)
ifeq ($(ENABLE_SFLOW), y)
SONIC_INSTALL_DOCKER_DBG_IMAGES += $(DOCKER_SFLOW_DBG)
SONIC_STRETCH_DBG_DOCKERS += $(DOCKER_SFLOW_DBG)
endif

$(DOCKER_SFLOW)_CONTAINER_NAME = sflow
$(DOCKER_SFLOW)_RUN_OPT += --net=host --privileged -t
$(DOCKER_SFLOW)_RUN_OPT += -v /etc/sonic:/etc/sonic:ro
$(DOCKER_SFLOW)_RUN_OPT += -v /host/warmboot:/var/warmboot

$(DOCKER_SFLOW)_BASE_IMAGE_FILES += psample:/usr/bin/psample
$(DOCKER_SFLOW)_BASE_IMAGE_FILES += sflowtool:/usr/bin/sflowtool
$(DOCKER_SFLOW)_FILES += $(SUPERVISOR_PROC_EXIT_LISTENER_SCRIPT)