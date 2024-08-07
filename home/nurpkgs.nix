{ sys, ... }: {
	home.packages = with sys.nur.repos; [
		mic92.hello-nur
	];
}
