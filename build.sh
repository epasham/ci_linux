
#remove outputs
rm -r ci_linux/output
mkdir ci_linux/output
mkdir ci_linux/output/nb-redis
mkdir ci_linux/output/nb-taskengine
mkdir ci_linux/output/nb-rabbitmq
mkdir ci_linux/output/nb-mongodb
mkdir ci_linux/output/nb-elasticsearch

#build images
echo "---------------build ./nb-redis---------------"
cd ci_linux/nb-redis
docker image build -t cg2-linux-asg/redis -f Dockerfile .
docker tag cg2-linux-asg/redis:latest 041444721655.dkr.ecr.us-east-1.amazonaws.com/cg2-linux-asg/redis:latest

#docker push 041444721655.dkr.ecr.us-east-1.amazonaws.com/cg2-linux-asg/redis:latest


cp readme ../output/nb-redis/
cp -r conf ../output/nb-redis/

echo "---------------build ./nb-taskengine---------------"
cd ../nb-taskengine
docker image build -t cg2-linux-asg/task-engine -f Dockerfile .
docker tag cg2-linux-asg/task-engine:latest 041444721655.dkr.ecr.us-east-1.amazonaws.com/cg2-linux-asg/task-engine:latest

#docker push 041444721655.dkr.ecr.us-east-1.amazonaws.com/cg2-linux-asg/task-engine:latest

cp readme ../output/nb-taskengine/
cp -r conf ../output/nb-taskengine/


cd ..
echo "---------------build completed. ---------------"
echo "you find image tar files in current directory"

