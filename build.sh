
#remove outputs
rm -r output
mkdir output
mkdir output/nb-redis
mkdir output/nb-taskengine
mkdir output/nb-rabbitmq
mkdir output/nb-mongodb
mkdir output/nb-elasticsearch

#build images
echo "---------------build ./nb-redis---------------"
cd ./nb-redis
docker image build -t nb-redis -f Dockerfile .

docker image save nb-redis --output ../output/nb-redis/nb-redis.tar

cp readme ../output/nb-redis/
cp -r conf ../output/nb-redis/

echo "---------------build ./nb-taskengine---------------"
cd ../nb-taskengine
docker image build -t nb-taskengine -f Dockerfile .

docker image save nb-taskengine --output ../output/nb-taskengine/nb-taskengine.tar

cp readme ../output/nb-taskengine/
cp -r conf ../output/nb-taskengine/


cd ..
echo "---------------build completed. ---------------"
echo "you find image tar files in current directory"
