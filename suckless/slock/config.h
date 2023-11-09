/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "wheel";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#000000",   /* during input */
	[FAILED] = "#cc241d",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;

/* time in seconds before the monitor shuts down */
static const int monitortime = 5;

/* default message */
static const char * message = "";

/* text color */
static const char * text_color = "#eeeeee";

/* text size (must be a valid size) */
static const char * font_name = "6x13";

