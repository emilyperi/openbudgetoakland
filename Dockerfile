FROM node:alpine

# Set up node user
RUN adduser -D openbudget

# Define HOME environment variable as /home/openbudget
ENV HOME /home/openbudget

# Copy contents of current directory to openbudget/repo in container
COPY . $HOME

# Set user of /home/node directory to be node (who we just created)
RUN chown -R openbudget $HOME

# Set working directory as home/node
WORKDIR $HOME

# Update apk
RUN \ 
	apk update  && \
	apk upgrade && \
	apk add bash && \
	apk add vim && \
	apk add git

# Save website files thatt have been changed
VOLUME ["$HOME"]

# Install yarn globally per openbudget instructions
RUN npm install -g harp

# Change User
USER openbudget

# Default command
CMD ["/bin/bash"]

