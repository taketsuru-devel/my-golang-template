print_usage() {
  printf "Usage: -p port"
}

port=0
while getopts '' flag; do
  case "${flag}" in
    p) port=${OPTARG} ;;
    *) print_usage
       exit 1 ;;
  esac
done

dir=${PWD##*/}

rm Dockerfile
sed -e "s/%DIR%/$dir/g" Dockerfile.tmpl | sed -e "s/%PORT%/$port/g" > Dockerfile
rm Dockerfile.tmpl
go mod init $dir
#rm -rf .git
